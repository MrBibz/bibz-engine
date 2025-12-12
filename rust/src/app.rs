use crate::error::GameError;
use winit::application::ApplicationHandler;
use winit::event::WindowEvent;
use winit::event_loop::ActiveEventLoop;
use winit::window::{Window, WindowId};

#[derive(Default)]
pub struct App {
    window: Option<Window>,
    error: Option<GameError>,
}

impl ApplicationHandler for App {
    fn resumed(&mut self, event_loop: &ActiveEventLoop) {
        match event_loop.create_window(Window::default_attributes()) {
            Ok(w) => { self.window = Some(w); },
            Err(e) => { panic!("{}", e); },
        }
    }

    fn window_event(&mut self, event_loop: &ActiveEventLoop, id: WindowId, event: WindowEvent) {
        match event {
            WindowEvent::CloseRequested => {
                event_loop.exit();
            },
            _ => (),
        }
    }
}