FROM gcr.io/distroless/base
WORKDIR /
COPY --chmod=555 server-linux ./server
EXPOSE 8080
EXPOSE 18080
CMD ["./server"]
