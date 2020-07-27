build:
	buildah bud -f Dockerfile -t  quay.io/behoward/tanger .

run:
	podman run --rm -it -p 8880:80 quay.io/behoward/tanger
