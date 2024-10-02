package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
)

func main() {
	addr := getEnv("SERVER_BIND_ADDR", ":8000")

	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(addr, nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	resp := "Hello World"
	jsonRespond(w, resp, http.StatusOK)
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

func getEnv(key string, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}
