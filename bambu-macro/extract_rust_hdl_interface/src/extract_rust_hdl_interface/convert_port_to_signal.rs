use crate::extract_verilog_interface::{DataSize, Direction, Port};

use super::{as_snake_case::as_snake_case, Signal, SignalType};

// trait IntoSignal {}
impl Port {
    pub fn into_signal(&self, clock_names: &[&str]) -> Signal {
        let has_clock_name = clock_names.iter().any(|e| e == &self.identifier);

        let signal_type = match self.data_size {
            DataSize::Bits(x) => SignalType::Bits(x),
            DataSize::Bit => {
                if has_clock_name {
                    SignalType::Clock
                } else {
                    SignalType::Bit
                }
            }
        };

        let driven = !matches!(&self.direction, Direction::In);

        let direction = self.direction;

        Signal {
            name: as_snake_case(self.identifier.as_str()),
            internal_name: self.identifier.to_string(),
            signal_type: signal_type,
            direction: direction,
            driven: driven,
        }
    }
}

impl From<Port> for Signal {
    fn from(port: Port) -> Self {
        port.into_signal(&["clk", "clock"])
    }
}

impl From<&Port> for Signal {
    fn from(port: &Port) -> Self {
        port.into_signal(&["clk", "clock"])
    }
}

#[cfg(test)]
mod tests {
    use crate::extract_verilog_interface::NetType;

    use super::*;

    #[test]
    fn converting_a_port_to_a_signal_works() {
        let port = Port {
            identifier: String::from("test"),
            direction: Direction::In,
            net_type: NetType::Wire,
            data_size: DataSize::Bits(9),
        };
        let signal: Signal = port.into();

        assert_eq!(signal.name, String::from("test"));
        assert_eq!(signal.direction, Direction::In);
        assert_eq!(signal.driven, false);
        assert_eq!(signal.signal_type, SignalType::Bits(9));
    }

    #[test]
    fn converting_a_port_to_signal_enforces_snake_case() {
        let port = Port {
            identifier: String::from("myPort"),
            direction: Direction::In,
            net_type: NetType::Wire,
            data_size: DataSize::Bits(9),
        };
        let signal: Signal = port.into();

        assert_eq!(signal.name, String::from("my_port"));
    }

    #[test]
    fn converting_a_output_port_makes_the_signal_driven() {
        let port = Port {
            identifier: String::from("test"),
            direction: Direction::Out,
            net_type: NetType::Wire,
            data_size: DataSize::Bits(9),
        };
        let signal: Signal = port.into();

        assert_eq!(signal.name, String::from("test"));
        assert_eq!(signal.direction, Direction::Out);
        assert_eq!(signal.driven, true);
        assert_eq!(signal.signal_type, SignalType::Bits(9));
    }

    #[test]
    fn detects_basic_clock_signal_by_name() {
        let clock_port = Port {
            identifier: String::from("clk"),
            direction: Direction::In,
            net_type: NetType::Wire,
            data_size: DataSize::Bit,
        };
        let clock_signal: Signal = clock_port.into();

        assert_eq!(clock_signal.name, String::from("clk"));
        assert_eq!(clock_signal.direction, Direction::In);
        assert_eq!(clock_signal.driven, false);
        assert_eq!(clock_signal.signal_type, SignalType::Clock);
    }

    #[test]
    fn does_not_detect_clock_signal_if_its_too_wide() {
        let not_a_clock_port = Port {
            identifier: String::from("clk"),
            direction: Direction::In,
            net_type: NetType::Wire,
            data_size: DataSize::Bits(3),
        };
        let not_a_clock_signal: Signal = not_a_clock_port.into();

        assert_eq!(not_a_clock_signal.name, String::from("clk"));
        assert_eq!(not_a_clock_signal.direction, Direction::In);
        assert_eq!(not_a_clock_signal.driven, false);
        assert_eq!(not_a_clock_signal.signal_type, SignalType::Bits(3));
    }
}
