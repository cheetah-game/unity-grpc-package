#!/bin/bash
protoc --plugin=protoc-gen-grpc=/usr/local/Cellar/grpc/1.33.2_3/bin/grpc_csharp_plugin --grpc_out=../Unity/Assets/Scripts/gRPC --csharp_out=../Unity/Assets/Scripts/gRPC service.proto