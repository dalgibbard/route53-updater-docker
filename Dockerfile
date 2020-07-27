# Route 53 updater for DDNS-like home network access.
#
FROM arm64v8/python:3.8-alpine

RUN apk --update add py3-pip \
	&& python3 -m pip install awscli iplookup boto boto3 botocore requests \
	&& rm -rf /var/cache/apk/*

RUN addgroup -S route53 \
    && adduser -G route53 -S -D route53
USER route53:route53

COPY main.py /

CMD [ "/usr/local/bin/python3", "-u", "/main.py" ]
