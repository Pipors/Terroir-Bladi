import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { PrismaModule } from 'src/prisma/prisma.module';
import { ExceptionModule } from '../exceptions/exception.module';
import { CooperativeService } from '../cooperatives/cooperative.service';
import { CooperativeModule } from '../cooperatives/cooperative.module';
import { ProductModule } from '../produtcs/product.module';

@Module({
  imports: [PrismaModule, CooperativeModule ,ExceptionModule, ProductModule],
  controllers: [UserController],
  providers: [UserService, CooperativeService]
})
export class UserModule {}
