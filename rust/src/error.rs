use thiserror::Error;
use winit::error::OsError;

#[derive(Debug, Error)]
pub enum GameError {
    #[error("Failed to communicate with the OS during window creation")]
    Os(#[from] OsError),
}