build:
	docker build -t cmr_stunnel .
run:
	docker run -p 443:443 -ti cmr_stunnel /bin/bash
