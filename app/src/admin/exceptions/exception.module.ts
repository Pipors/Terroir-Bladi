import { Module } from "@nestjs/common";
import { HttpError } from "./http.err";


@Module({
	imports: [],
	providers: [HttpError],
	exports: [HttpError]
})

export class ExceptionModule {}
