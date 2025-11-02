import { Injectable, Inject, forwardRef } from "@nestjs/common";
import { PrismaService } from "../../prisma/prisma.service";

import { Timestamp } from "rxjs";
import { CreateProductDto } from "src/dto/product DTO/createproduct.dto";
import { CooperativeService } from "../cooperatives/cooperative.service";


@Injectable()
export class ProductService {
  constructor(
    @Inject(forwardRef(() => CooperativeService))
    private readonly prisma: PrismaService,
    private readonly cooperative: CooperativeService) { }

  async getAll() {
    // Get products with relations
    const products = await this.prisma.product.findMany({

      include: {
        cooperative: {
          select: {
            id: true,
            name_ar: true,
            name_fr: true,
            name_en: true,
            region: true,
            city: true,
            isVerified: true,
          }
        },
        category: {
          select: {
            id: true,
            name_ar: true,
            name_fr: true,
            name_en: true,
            slug: true,
          }
        },
        _count: {
          select: {
            reviews: true,
            orderItems: true,
          }
        }
      },
      orderBy: { createdAt: 'desc' },
      take: 15,

    })
    return products
  }

  async createProduct(data: CreateProductDto | any) {

    const coop: any = await this.cooperative.getCoopById(data.cooperativeId)

    const checkProduct = await this.prisma.product.findFirst({
      where: {
        cooperativeId: coop?.id,
        name_ar: data.name_ar,
        name_fr: data.name_fr,
        name_en: data.name_en
      }
    }) 
    if (checkProduct)
    {
      return ({
        status: 409,
        message:  "Product Name already exist in your shop"
      })
    }
    else {
      const newProduct = await this.prisma.product.create(data)
      if (newProduct){
        return ({
          status: 201,
          message:  "Product added to your shop successfully",
          data: newProduct
        })
      }
      else{
        return ({
          status: 400,
          message: "Required fields should not empty"
        })
      }
    }
  }
}