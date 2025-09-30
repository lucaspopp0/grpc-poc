module github.com/lucaspopp0/grpc-poc/server

go 1.24.4

replace github.com/lucaspopp0/grpc-poc/gen/go => ../gen/go

require (
	github.com/getkin/kin-openapi v0.133.0
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.27.2
	github.com/lucaspopp0/grpc-poc/gen/go v0.0.0
	golang.org/x/sync v0.16.0
	google.golang.org/grpc v1.75.1
)

require (
	github.com/go-openapi/jsonpointer v0.21.0 // indirect
	github.com/go-openapi/swag v0.23.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/mohae/deepcopy v0.0.0-20170929034955-c48cc78d4826 // indirect
	github.com/oasdiff/yaml v0.0.0-20250309154309-f31be36b4037 // indirect
	github.com/oasdiff/yaml3 v0.0.0-20250309153720-d2182401db90 // indirect
	github.com/perimeterx/marshmallow v1.1.5 // indirect
	github.com/woodsbury/decimal128 v1.3.0 // indirect
	golang.org/x/net v0.41.0 // indirect
	golang.org/x/sys v0.33.0 // indirect
	golang.org/x/text v0.28.0 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20250818200422-3122310a409c // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250818200422-3122310a409c // indirect
	google.golang.org/protobuf v1.36.9 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
