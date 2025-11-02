import { HttpException, HttpStatus, Injectable } from "@nestjs/common";


export class HttpError extends HttpException {

	async handleError(e: any){
		switch(e?.code) {
			case "ERR_HTTP_HEADERS_SENT":
				return ({ message: "BAD REQUEST", status: Number(HttpStatus.BAD_REQUEST)})
			default:
				return ({message: "Internal Server Error", status: Number(HttpStatus.SERVICE_UNAVAILABLE)})
		}
	}
}