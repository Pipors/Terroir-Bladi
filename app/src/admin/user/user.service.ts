import { forwardRef, Injectable, Inject } from "@nestjs/common";
import { User } from "@prisma/client";
import { PrismaClientKnownRequestError, PrismaClientRustPanicError} from "@prisma/client/runtime/library";
import { PrismaService } from "src/prisma/prisma.service";
import { CooperativeService } from "../cooperatives/cooperative.service";
import { CreateUserDTO } from "src/dto/user DTO/createuser.dto";
import { CreateCooperativetDto } from "src/dto/cooperative DTO/createcooperative.dto";
import { validate } from "class-validator";
import { plainToInstance } from "class-transformer";
// import UserCreateInput 
 


@Injectable()
export class UserService {
	constructor(
		private readonly cooperative: CooperativeService,
		private readonly prisma: PrismaService) { }

	// The user must be filtered by the email
	// even searching for a user will be only with first and last name
	// this give a problem to the users with same names
	// i should i add a specific and unique identifier for 
	// every new user and that identifier will be public info
	async getUserByName(firstname: string): Promise<User | undefined>{
		try{
			const user = await this.prisma.user.findFirstOrThrow({
				where: {
					AND: [
						// { email: firstname},
						{ firstName: firstname}
					]
				}
			})
			return user;
		} catch (e: unknown){
			if (e instanceof PrismaClientKnownRequestError && (e as any).code === 'P2025'){

				// console.log('Viva->', e)
			}
		}
		return undefined;
	}

	async getAllUsers() {

	}


	/************************************************************/
	async createUser(data: any) {
		try {
			const user = await this.prisma.user.findFirstOrThrow({
				where: {
					OR: [
						{ email: data.email },
						{ phone: data.phone }
					]
				}
			})
			if (user?.email === data?.email || user?.phone === data.phone) {
				return ({
					status: 409,
					message: `The email "${data.email}" already exists... please login instead or provide a new address mail`
				})
			}
		} catch (e: unknown) {
			try {
				if (e instanceof PrismaClientKnownRequestError && (e as any).code === "P2025") {
					const result = await validate(plainToInstance(CreateUserDTO, data))
					console.log(result)
					if (result.length > 0){
						return ({
							status: 400,
							message: 'Please provide correct user informations',
						})
					}
					else{
						const role = String(data.role).toUpperCase()
						if (role === 'CUSTOMER'){
							const newUser: User = await this.prisma.user.create({ data })
							if (newUser) {
								console.log('cust')
								return ({
									status: 201,
									message: `user ${newUser.firstName} has been created successfully`
								})
							}
						}
						else {
							return ({
								status: 400,
								message: `UNAUTHORIZED`
							})
						}
					
					}
				}
			} catch (e: unknown){
				if (e instanceof PrismaClientRustPanicError){
					return ({
						status: 503,
						message: `The server has faced a problem while processing your request... Please try again`
					})
				}
			}
		}
	}
}