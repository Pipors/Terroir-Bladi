import { Controller, Get, Post, Put, Patch, Delete, Body, Param, Res, HttpCode } from "@nestjs/common";
import { CooperativeService } from "./cooperative.service";
import { Query } from "@nestjs/common";
import { ResolveFnOutput } from "module";
import { CreateCooperativetDto } from "src/dto/cooperative DTO/createcooperative.dto";
import { UpdateCooperativetDto } from "src/dto/cooperative DTO/updatecooperative.dto";
import { NotFoundError } from "rxjs";
import { ExceptionsHandler } from "@nestjs/core/exceptions/exceptions-handler";
import { HttpError } from "../exceptions/http.err";
import { HttpException, HttpStatus } from "@nestjs/common";
import { plainToInstance } from "class-transformer";
import { validate } from "class-validator";
import { exit } from "process";


/**
 * CooperativeController handles the API requests related to cooperatives.
 * It provides methods to create, retrieve, and update cooperative information.
 */
@Controller('api/admin')
export class CooperativeController {
	constructor(
		private readonly cooperativeService: CooperativeService,
		private readonly httpError: HttpError) { }

	/**
	 * Sends a 403 Forbidden response.
	 * @param res - The response object.
	 * @param _status - The status code.
	 * @param _message - The message to send.
	 * @param _data - Additional data to send.
	 */
	async res_403(@Res() res, _status: number, _message: string, _data: any) {
		return (
			res.json({
				status: _status,
				message: _message,
				data: _data
			})
		)
	}

	/**
	 * Sends a 202 Accepted response.
	 * @param res - The response object.
	 * @param _status - The status code.
	 * @param _message - The message to send.
	 * @param _data - Additional data to send.
	 */
	async res_202(@Res() res, _status: number, _message: string, _data: any) {
		return (
			res.json({
				status: _status,
				message: _message,
				data: _data
			})
		)
	}

	/**
	 * Retrieves all cooperatives.
	 * @param res - The response object.
	 */
	@Get('cooperatives')
	async getAllCoop(@Res() res) {
		const getAll = await this.cooperativeService.getAllCoop()
		return this.res_202(res, 200, "Success", getAll.data)
	}

	/**
	 * Retrieves a cooperative by its ID.
	 * @param id - The ID of the cooperative.
	 * @param res - The response object.
	 */
	@Get('cooperatives/:id')
	async getCoopByIdd(@Param('id') id: string, @Res() res) {
		try {
			if (!id)
				await this.res_403(res, 403, "Can not read CooperativesID needed", null)
			const coop = await this.cooperativeService.getCoopById(id)
			if (coop === null){
				await this.res_403(res, 403, "You access this ressource", null)
			}
			return await this.res_202(res, 200, "Success", coop)
		}
		catch (e: any) {
			const error = this.httpError.handleError(e)
			console.log(await error)
		}
	}

	/**
	 * Creates a new cooperative.
	 * @param data - The data for the new cooperative.
	 * @param res - The response object.
	 */
	@Post('cooperatives')
	async creatNewCoop(@Body() data: any, @Res() res) {
		const check = plainToInstance(CreateCooperativetDto, data)
		const result = await validate(check)
		console.log('result->', result.length);

		
		if (result.length > 0){
			console.log('rah tema nit')
			return this.res_403(res, 400, 'ara data m9ada wla 9awad', null)
		}
		else{const coop = await this.cooperativeService.createNewCoop(data)
		if (coop?.status === 201) {
			return this.res_202(res, 201, coop!.message, coop!.data)
		}
		else if (coop?.status === 409)
			return this.res_403(res, 409, coop.message, null)
		else
			return this.res_403(res, 400, "Error occured while creating new Cooperative please try again\nIf the problem persist please contact the support team", null)
	}}

	/**
	 * Updates the information of a cooperative.
	 * @param data - The updated data for the cooperative.
	 * @param res - The response object.
	 */
	@Patch('cooperatives/:id')
	async updateCoopInfo(@Body() data, @Res() res) {
		console.log("PAYLAOD ->", data)
		const coop = await this.cooperativeService.updateCoopInfo(data);
		return this.res_202(res, 204, coop!.message, data)
	}


	@Delete('cooperatives/:id')
	async deleteCoop(@Param() data: CreateCooperativetDto, @Res() res) {
		const result = await this.cooperativeService.deleteCoop(data)
		if (result?.status === 202)
			this.res_202(res, result.status, result.message, null)
		else
			this.res_403(res, 404, "not found a sahbi", null)
	}
}
// Request 10.30.253.64:3200/api/admin/cooperatives?_id=user_002
// @Get('cooperatives')
// async getCoopById(@Query('_id') id: string, @Res() res) {
// 	// console.log('id ->', id)
// 	try {
// 		if (!id)
// 			await this.res_403(res, 403, "Can not read CooperativesID needed", null)
// 		const coop = await this.cooperativeService.getCoopById(id)
// 		// console.log('coop from controller', coop)
// 		if (coop === null)
// 			await this.res_403(res, 403, "You can't access this ressource", null)
// 		return await this.res_202(res, 200, "Success", coop)
// 	}
// 	catch (e) {
// 		console.log("-->", e)
// 	}
// 