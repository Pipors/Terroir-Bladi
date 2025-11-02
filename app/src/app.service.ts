import { Injectable } from '@nestjs/common';
import { ProductService } from './admin/produtcs/product.service';



@Injectable()
export class AppService {
  constructor(private readonly productServive: ProductService){}
  getHello(): any {
    // return this.productServive.getAll()
  }
}

