import { Controller, Get, Post, Patch, Delete, Body, Res } from "@nestjs/common";
import { ProductService } from "./product.service"
import { PrismaService } from "../../prisma/prisma.service";
import { CreateProductDto } from "src/dto/product DTO/createproduct.dto";
import { JsonArray } from "@prisma/client/runtime/library";

@Controller('api/admin')

export class ProductController {
  constructor(
    private readonly productService: ProductService,
    private readonly prisma: PrismaService) { }



    async res_202(@Res() res, _status: number, _message: string, _data: any) {
      return (
        res.json({
          status: _status,
          message: _message,
          data: _data
        })
      )
    }
  //Get All Products
  @Get('products')
  async getAll(@Body() body): Promise<object> {
    // console.log(body.to_string())
    return this.productService.getAll();
  }

  //Create New Product
  @Post('products')
  async createNewProduct(@Body() data: CreateProductDto, @Res() res) {
    try {
      const create: any = await this.productService.createProduct(data)
      if (create?.status === 201){
        return this.res_202(res, 201, create.message, create.data)
      }
      else{
        return ({
          status: 500,
          message: "Internal Server Error"
        })
      }
    }
    catch (e: any)
    {
      console.log('Error ->', e)
    }
  }


  //Get Product by ID
  @Get()
  async getProductById(){

  }


  //Update Product
  @Patch()
  async updateProduct() {
    
  }

  //Delete Product
  @Delete()
  async deleteProduct() {

  }
}