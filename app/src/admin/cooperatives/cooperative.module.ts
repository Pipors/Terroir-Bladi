import { Module } from "@nestjs/common";
import {CooperativeController} from "./cooperative.controller";
import { CooperativeService } from "./cooperative.service";
import { ProductService } from "../produtcs/product.service";
import { PrismaService } from "src/prisma/prisma.service";
import { ProductModule } from "../produtcs/product.module";
import { PrismaModule } from "src/prisma/prisma.module";
import { AppModule } from "src/app.module";
import { HttpError } from "../exceptions/http.err";
import { ExceptionModule } from "../exceptions/exception.module";


@Module({
	imports: [ProductModule, PrismaModule, ExceptionModule],
	controllers: [CooperativeController],
	providers: [CooperativeService, PrismaService],
	exports: [CooperativeService]
})


export class CooperativeModule{}