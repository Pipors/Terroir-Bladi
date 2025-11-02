import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ProductService } from './admin/produtcs/product.service';

@Controller()
export default class AppController {
  constructor(private readonly appService: AppService, private readonly product: ProductService) {}

  @Get()
  getHello(): any {
    return this.product.getAll();
  }
}
