use tonic::transport::Server;
use tonic::Response;

pub mod service {
    tonic::include_proto!("grpc.service");
}

#[derive(Default)]
pub struct SomeGameServer {}

#[tonic::async_trait]
impl service::game_server::Game for SomeGameServer {
    async fn set_position(&self, request: tonic::Request<service::Vector3d>) -> Result<tonic::Response<service::Vector3d>, tonic::Status> {
        println!("hello from server");
        Ok(Response::new(service::Vector3d{
            x: 3.0,
            y: 4.0,
            z: 5.0
        }))
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "127.0.0.1:5001".parse().unwrap();

    Server::builder()
        .add_service(service::game_server::GameServer::new(SomeGameServer::default()))
        .serve(addr)
        .await?;
    Ok(())
}