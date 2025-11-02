import { Module } from '@nestjs/common';
import { ProductController } from './product.controller';
// import { ProductService } from './product.service';
// import { PrismaClient } from '@prisma/client';
import { PrismaService } from '../../prisma/prisma.service';
import { PrismaClient } from '@prisma/client';
import { ProductService } from './product.service';
import { PrismaModule } from 'src/prisma/prisma.module';
import { CreateProductDto } from 'src/dto/product DTO/createproduct.dto';
import { CooperativeService } from '../cooperatives/cooperative.service';
import { CooperativeModule } from '../cooperatives/cooperative.module';
// import {PrismaClient}  from '../../../generated/prisma';
import { ExceptionModule } from '../exceptions/exception.module';

@Module({
  imports: [PrismaModule, ExceptionModule],
  controllers: [ProductController],
  providers: [ProductService, PrismaService, CooperativeService],
  exports: [ProductService]
})
export class ProductModule {}