use tonic::transport::Server;
use tonic::Response;

pub mod service {
    tonic::include_proto!("grpc.service");
}

#[derive(Default)]
pub struct SomeGameServer {}

#[tonic::async_trait]
impl service::game_server::Game for SomeGameServer {
    async fn increment(
        &self,
        request: tonic::Request<service::NumberValue>,
    ) -> Result<tonic::Response<service::NumberValue>, tonic::Status> {
        Ok(Response::new(service::NumberValue {
            value: request.get_ref().value + 1,
        }))
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "0.0.0.0:5001".parse().unwrap();
    Server::builder()
        .add_service(service::game_server::GameServer::new(
            SomeGameServer::default(),
        ))
        .serve(addr)
        .await?;
    Ok(())
}
