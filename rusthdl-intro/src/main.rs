mod counter;
mod counter_embedded;
mod quickstart;

use counter::counter;
use counter_embedded::counter_embedded;
use quickstart::{generate_blinky, simulate_blinky};

fn main() {
    counter();
    counter_embedded();
    generate_blinky();
    simulate_blinky();
}
