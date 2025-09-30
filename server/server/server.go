package server

import (
	"context"
	"log"
	"net"
	"net/http"

	"github.com/grpc-ecosystem/grpc-gateway/v2/runtime"
	"github.com/lucaspopp0/grpc-poc/gen/go/api"
	"golang.org/x/sync/errgroup"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/reflection"
)

type server struct {
	api.UnimplementedExampleAPIServer
}

var _ api.ExampleAPIServer = (*server)(nil)

func Run() {
	ctx := context.Background()
	g, ctx := errgroup.WithContext(ctx)

	// Start gRPC server
	grpcLis, err := net.Listen("tcp", ":18080")
	if err != nil {
		log.Fatalf("failed to listen for gRPC: %v", err)
	}

	grpcServer := grpc.NewServer()
	api.RegisterExampleAPIServer(grpcServer, &server{})
	reflection.Register(grpcServer)

	g.Go(func() error {
		log.Printf("gRPC server listening at %v", grpcLis.Addr())
		return grpcServer.Serve(grpcLis)
	})

	// Start HTTP gateway server
	mux := runtime.NewServeMux()
	opts := []grpc.DialOption{grpc.WithTransportCredentials(insecure.NewCredentials())}

	err = api.RegisterExampleAPIHandlerFromEndpoint(ctx, mux, "localhost:18080", opts)
	if err != nil {
		log.Fatalf("failed to register gateway: %v", err)
	}

	httpServer := &http.Server{
		Addr:    ":8080",
		Handler: mux,
	}

	g.Go(func() error {
		log.Printf("HTTP gateway listening at :8080")
		return httpServer.ListenAndServe()
	})

	if err := g.Wait(); err != nil {
		log.Fatalf("server error: %v", err)
	}
}
