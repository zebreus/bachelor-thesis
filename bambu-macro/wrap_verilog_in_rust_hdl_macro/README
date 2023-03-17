# wrap_verilog_in_rust_hdl_macro

<!-- cargo-rdme start -->

Provides a [`wrap_verilog!`] macro that can be used to wrap a verilog module in a Rust struct.

### Example

```rust
use wrap_verilog_in_rust_hdl_macro::wrap_verilog;

wrap_verilog!("module test(); endmodule", "test");
```

#### Bigger example

In this example we are going to wrap the following Verilog module:

```verilog
module counter
(
    input clock,
    output [5:0] led
);
    reg [23:0] clockCounter = 0;
    localparam WAIT_TIME = 1000;
    reg [5:0] ledCounter = 0;
    
    always @(posedge clock) begin
        clockCounter <= clockCounter + 1;
        if (clockCounter == WAIT_TIME) begin
            clockCounter <= 0;
            ledCounter <= ledCounter + 1;
        end
    end
    
    assign led = ~ledCounter;
endmodule
```

To generate a rust-hdl compatible struct we can use the [`wrap_verilog!`] macro. The macro takes a string literal containing Verilog and the module name as inputs.

```rust
use wrap_verilog_in_rust_hdl_macro::wrap_verilog;

wrap_verilog!(
r#"
module counter
(
    input clock,
    output [5:0] led
);

reg [23:0] clockCounter = 0;
localparam WAIT_TIME = 1000;
reg [5:0] ledCounter = 0;

always @(posedge clock) begin
    clockCounter <= clockCounter + 1;
    if (clockCounter == WAIT_TIME) begin
        clockCounter <= 0;
        ledCounter <= ledCounter + 1;
    end
end

assign led = ~ledCounter;
endmodule
"#,
    "counter"
);
```

This expands to the following struct and logic implementation:

```rust
use rust_hdl::prelude::*;
#[derive(LogicBlock, Default)]
struct Counter {
    pub clock: Signal<
        In,
        Clock,
    >,
    pub led: Signal<
        Out,
        Bits<6usize>,
    >,
}

impl Logic for Counter {
    fn update(&mut self) {}
    fn connect(&mut self) {
        self.led.connect();
    }
    fn hdl(&self) -> Verilog {
        Verilog::Wrapper(Wrapper {
            code: "counter counter_inst(.clock(clock), .led(led));".into(),
            cores: r#"
                module counter
                (
                    input clock,
                    output [5:0] led
                );
                
                reg [23:0] clockCounter = 0;
                localparam WAIT_TIME = 1000;
                reg [5:0] ledCounter = 0;
                
                always @(posedge clock) begin
                    clockCounter <= clockCounter + 1;
                    if (clockCounter == WAIT_TIME) begin
                        clockCounter <= 0;
                        ledCounter <= ledCounter + 1;
                    end
                end
                
                assign led = ~ledCounter;
                endmodule
                "#.into(),
        })
    }
}
```

### Limitations

* The generated module is just a rust-hdl wrapper around verilog.
* The generated module can not be simulated with rust-hdl because it does not support simulating verilog.
* You need to explicitly specify the name of the toplevel module, as we cannot detect it automatically.

<!-- cargo-rdme end -->
