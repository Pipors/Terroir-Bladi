import { Controller, Get, Post, Patch, Delete, Body, Param } from "@nestjs/common";
import { UserService } from "./user.service";
import { CreateUserDTO } from "src/dto/user DTO/createuser.dto";
import { User } from "@prisma/client";

@Controller('api/admin')
export class UserController {
	constructor(private readonly userService: UserService) { }



	@Get('users/:firstName')
	async getUserByName(@Param('firstName') firstName: string){
		const user: User | undefined = await this.userService.getUserByName(firstName)
		if (user === undefined){
			return ({
				status: 404,
				message: `User ${firstName} is not found`
			})
		}
		else{
			return ({
				status: 200,
				message: user
			})
		}
	}


	@Post('users')
	async createUser(@Body() data: CreateUserDTO | User) {
		const result = await this.userService.createUser(data)
		if (result?.status === 201) {
			return ({
				status: 201,
				message: "user created successfully"
			})
		}
		else{
			return ({
				status: result?.status,
				message: result?.message
			})
		}
	}

}


