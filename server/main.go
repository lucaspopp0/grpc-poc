package main

import "github.com/lucaspopp0/grpc-poc/gen/go/api"

func main() {
	_ = api.NewExampleAPIClient(nil)
}
