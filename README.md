# gRPC PoC

A proof-of-concept gRPC service with HTTP/REST gateway using grpc-gateway.

## Project Structure

- `proto/` - Protocol Buffer definitions
- `gen/` - Generated code (Go & OpenAPI)
- `server/` - gRPC server implementation
- `client/` - gRPC client implementation

## Prerequisites

- Go 1.24+
- protoc

## Quick Start

```bash
# Generate code
make gen

# Run server (gRPC: 18080, HTTP: 8080)
go run server/main.go

# Test gRPC (Go client)
go run client/main.go -id test-123

# Test gRPC (grpcurl)
grpcurl \
  -plaintext \
  -d '{"id": "test123"}' \
  localhost:18080 \
  api.ExampleAPI/GetThing

# Test HTTP
curl http://localhost:8080/v1/things/test-123
```

## API Endpoints

- `GET /v1/things/{id}` - Get a thing
- `PUT /v1/things/{thing.id}` - Update a thing

## Workspaces

Uses Go workspaces with modules:
- `gen/go` - Generated code
- `server` - Server
- `client` - Client
