package main

import (
	"encoding/json"
	"k8s/services/pkg/getEnv"
	"log"
	"net/http"
	"strconv"
)

func main() {
	addr := getEnv.GetEnv("SERVER_BIND_ADDR", ":1235")

	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(addr, nil))
}

type jsonResp struct {
	Code string `json:"code"`
	Data string `json:"data"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	code := http.StatusOK

	resp := jsonResp{
		Code: strconv.Itoa(code),
		Data: "This is api app",
	}
	jsonRespond(w, resp, code)
}

func jsonRespond(w http.ResponseWriter, payload any, code int) {
	w.WriteHeader(code)
	if payload != nil {
		w.Header().Set("Content-Type", "application/json")
		if err := json.NewEncoder(w).Encode(payload); err != nil {
			log.Println(err)
		}
	}
}
