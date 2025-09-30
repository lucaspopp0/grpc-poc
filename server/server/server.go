package server

import (
	"log"
	"net"

	"github.com/lucaspopp0/grpc-poc/gen/go/api"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type server struct {
	api.UnimplementedExampleAPIServer
}

var _ api.ExampleAPIServer = (*server)(nil)

func Run() {
	lis, err := net.Listen("tcp", ":18080")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	api.RegisterExampleAPIServer(s, &server{})
	reflection.Register(s)

	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
