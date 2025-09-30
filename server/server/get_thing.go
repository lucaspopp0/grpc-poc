package server

import (
	"context"
	"log"

	"github.com/lucaspopp0/grpc-poc/gen/go/api"
	"github.com/lucaspopp0/grpc-poc/gen/go/model"
)

func (s *server) GetThing(ctx context.Context, req *api.GetThingRequest) (*api.GetThingResponse, error) {
	log.Printf("GetThing called with ID: %s", req.Id)

	return &api.GetThingResponse{
		Thing: &model.Thing{
			Id:   req.Id,
			Name: "Example Thing",
		},
	}, nil
}
