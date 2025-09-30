FROM gcr.io/distroless/base
WORKDIR /
COPY --chmod=555 server-linux ./server
EXPOSE 8083
CMD ["./server"]
