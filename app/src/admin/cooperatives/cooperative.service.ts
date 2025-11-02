import { Injectable, Inject, forwardRef, HttpException } from "@nestjs/common";
import { CreateProductDto } from "src/dto/product DTO/createproduct.dto";
import { PrismaService } from "src/prisma/prisma.service";
import { ProductService } from "../produtcs/product.service";
import { CreateCooperativetDto } from "src/dto/cooperative DTO/createcooperative.dto";
import { checkPrimeSync } from "crypto";
import { isObject, validate } from "class-validator";
import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";
import { HttpError } from "../exceptions/http.err";
import { plainToInstance } from "class-transformer";


type Cooperative = {
	id: string | null,
	userId: string | null,
	name_ar: string | null,
	name_fr: string | null,
	name_en: string | null,
	description_ar: string | null,
	description_fr: string | null,
	description_en: string | null,
	region: string | null,
	city: string | null,
	address: string | null,
	phone: string | null,
	email: string | null,
	website: string | null,
	establishedYear: number | null,
	memberCount: number | null,
	licenseNumber: string | null,
	isVerified: boolean | null,
	isActive: boolean | null,
	logo: string | null,
	coverImage: any | null,
	specialties: any | null,
	certifications: any | null,
	createdAt: Date | null,
	updatedAt: Date | null
}

@Injectable()
export class CooperativeService {
	constructor(
		@Inject(forwardRef(() => ProductService))
		private readonly product: ProductService,
		private readonly prisma: PrismaService,
		private readonly httpError: HttpError
	) { }


	async getCoopById(id: string): Promise<Cooperative | null> {
		try {
			const coop = await this.prisma.cooperative.findUnique({
				where: {
					userId: id
				}
			})
			console.log('id from service ->', id, coop)
			if (coop === null)
				return null;
			return coop
		} catch (e: any) {
			// const error = this.httpError.handleHttpError(e)
			// console.log('ERROR ->', error)
		}
		return null
	}


	async addNewProduct(data: CreateProductDto): Promise<boolean> {

		const newProduct = await this.product.createProduct(data)
		return true
	}


	async getAllCoop() {
		const getAllEntities = await this.prisma.cooperative.findMany({
			take: 10
		})
		return ({
			status: 201,
			message: `Your successfully`,
			data: getAllEntities
		})
	}


	async createNewCoop(data: CreateCooperativetDto | any) {
		const result = await validate(plainToInstance(CreateCooperativetDto, data))
		if (result.length > 0) {
			return ({
				status: 400,
				message: 'Please provide correct cooperative informations',
			})
		}
		else{
			const checkCoop = await this.prisma.cooperative.findFirstOrThrow({
				where: {
					OR: [
						{ name_ar: data.name_ar },
						{ name_fr: data.name_fr },
						{ name_en: data.name_en },
						{ email: data.email },
						{ phone: data.phone },
					]
				}
			})

			if (checkCoop) {
				return {
					status: 409,
					message: `Cooperative ${checkCoop.description_ar} already exist`
				}
			}
			else {
				const newCoop = await this.prisma.cooperative.create(data)
				if (newCoop) {
					return ({
						status: 201,
						message: `Your cooperative ${newCoop.name_ar} has been created successfully`,
						data: newCoop
					})
				}
			}
		}
	}
	async updateCoopInfo(data) {
		const coop = await this.prisma.cooperative.findUnique({
			where: {
				id: data.id
			}
		})
		let updateCoop: any = 0;
		const date_ = new Date()
		// const check = Object(coop)
		// Object.keys(data).forEach((key) => {
		updateCoop = await this.prisma.cooperative.update({
			where: {
				id: data.id
			},
			data: data
		})
		if (updateCoop) {
			updateCoop.updatedAt = date_
			console.log('data to change ->\n', updateCoop)
			return ({ stauts: 202, message: 'Values updated Successfully' })
		}
		return ({ stauts: 509, message: 'Server Error Occured... Please try after a while' })
	}


	async deleteCoop(data: any) {
		try {
			const delCoop: Cooperative = await this.prisma.cooperative.delete({
				where: {
					id: data.id
				}
			})
			if (delCoop)
				return ({ message: "Cooperative has been deleted successfully", status: 202 })
		} catch (e: unknown) {
			const error = this.prisma.handleCooepeartivesError(e, data.name_ar)
			console.log('ERROR ->', (await error).message)
		}
	}
}