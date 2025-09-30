package server

import (
	"context"
	"log"

	"github.com/lucaspopp0/grpc-poc/gen/go/api"
	pb "github.com/lucaspopp0/grpc-poc/gen/go/api"
)

func (s *server) PutThing(ctx context.Context, req *api.PutThingRequest) (*api.PutThingResponse, error) {
	log.Printf("PutThing called with Thing: %+v", req.Thing)

	return &pb.PutThingResponse{
		Thing: req.Thing,
	}, nil
}
