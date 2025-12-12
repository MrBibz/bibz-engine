mod app;
mod error;

use crate::app::App;
use winit::event_loop::{ControlFlow, EventLoop};

fn run() {
    let event_loop = EventLoop::new();

    event_loop.set_control_flow(ControlFlow::Poll);

    let mut app = App::default();
    event_loop.run_app(&mut app);
}