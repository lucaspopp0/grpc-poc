module github.com/lucaspopp0/grpc-poc/server

go 1.24.4

replace github.com/lucaspopp0/grpc-poc/gen/go => ../gen/go

require github.com/lucaspopp0/grpc-poc/gen/go v0.0.0-00010101000000-000000000000

require (
	golang.org/x/net v0.41.0 // indirect
	golang.org/x/sys v0.33.0 // indirect
	golang.org/x/text v0.26.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250707201910-8d1bb00bc6a7 // indirect
	google.golang.org/grpc v1.75.1 // indirect
	google.golang.org/protobuf v1.36.9 // indirect
)
