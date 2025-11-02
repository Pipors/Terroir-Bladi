import { Module } from '@nestjs/common';
import AppController from './app.controller';
import { AppService } from './app.service';
import { ProductModule } from './admin/produtcs/product.module';
import { ProductService } from './admin/produtcs/product.service';
import { PrismaService } from './prisma/prisma.service';
import { PrismaModule } from './prisma/prisma.module';
//import {ConfigModule} from '@nestjs/config'
import { CooperativeService } from './admin/cooperatives/cooperative.service';
import { CooperativeModule } from './admin/cooperatives/cooperative.module';
import { ExceptionModule } from './admin/exceptions/exception.module';
import { UserModule } from './admin/user/user.module';
import { UserService } from './admin/user/user.service';

@Module({
  imports: [
    CooperativeModule,
    ProductModule,
    PrismaModule,
    ExceptionModule,
    UserModule
  ],
  controllers: [AppController],
  providers: [
    AppService,
    ProductService,
    CooperativeService,
    UserService,
    PrismaService
  ],
})
export class AppModule {}

