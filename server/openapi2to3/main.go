package main

import (
	"encoding/json"
	"os"

	"github.com/getkin/kin-openapi/openapi2"
	"github.com/getkin/kin-openapi/openapi2conv"
)

const (
	inputFile  = "./gen/openapi/api.swagger.json"
	outputFile = "./gen/openapi/openapi.json"
)

func main() {
	input, err := os.ReadFile(inputFile)
	if err != nil {
		panic(err)
	}

	var doc2 openapi2.T

	if err = json.Unmarshal(input, &doc2); err != nil {
		panic(err)
	}

	doc3, err := openapi2conv.ToV3(&doc2)
	if err != nil {
		panic(err)
	}

	output, err := json.MarshalIndent(doc3, "", "  ")
	if err != nil {
		panic(err)
	}
	if err = os.WriteFile(outputFile, output, 0644); err != nil {
		panic(err)
	}
}
