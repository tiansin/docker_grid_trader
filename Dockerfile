FROM alpine:3

ENV PLATFORM="binance_spot" \
    SYMBOL="BNBUSDT" \
    API_DOMAIN="binance.com" \
    API_KEY="" \
    API_SECRET="" \
    GAP_PERCENT="0.01" \
    QUANTITY="1" \
    MIN_PRICE="0.0001" \
    MIN_QTY="0.01" \
    MAX_ORDERS="1" \
    PROXY_HOST="" \
    PROXY_PORT="0" 

COPY ./binance_grid_trader /root/binance_grid_trader
WORKDIR /root/binance_grid_trader

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apk --no-cache add \
                        jq \
                        curl \
                        moreutils \
                        py3-pip && \
    pip install --upgrade pip   && \
    pip install -r requirements.txt

CMD cat config.json | \
    jq ".platform = \"${PLATFORM}\"" | \
    jq ".symbol = \"${SYMBOL}\"" | \
    jq ".api_domain = \"${API_DOMAIN}\"" | \
    jq ".api_key = \"${API_KEY}\"" | \
    jq ".api_secret = \"${API_SECRET}\"" | \
    jq ".gap_percent = \"${GAP_PERCENT}\"" | \
    jq ".quantity = \"${QUANTITY}\"" | \
    jq ".min_price = \"${MIN_PRICE}\"" | \
    jq ".min_qty = \"${MIN_QTY}\"" | \
    jq ".max_orders = \"${MAX_ORDERS}\"" | \
    jq ".proxy_host = \"${PROXY_HOST}\"" | \
    jq ".proxy_port = \"${PROXY_PORT}\"" | sponge config.json && \
    python3 -u main.py