package main

import (
	"context"
	"flag"
	"log"
	"time"

	pb "github.com/lucaspopp0/grpc-poc/gen/go/api"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

var (
	addr = flag.String("addr", "localhost:50051", "the address to connect to")
	id   = flag.String("id", "test-123", "the thing ID to get")
)

func main() {
	flag.Parse()

	conn, err := grpc.NewClient(*addr, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("failed to connect: %v", err)
	}
	defer conn.Close()

	c := pb.NewExampleAPIClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	log.Printf("Getting thing with ID: %s", *id)
	resp, err := c.GetThing(ctx, &pb.GetThingRequest{Id: *id})
	if err != nil {
		log.Fatalf("could not get thing: %v", err)
	}

	log.Printf("Response: %+v", resp.Thing)
}
