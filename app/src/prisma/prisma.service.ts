import { Injectable,
  OnModuleInit,
  ConflictException,
  NotFoundException,
  BadRequestException,
  InternalServerErrorException,
  ServiceUnavailableException } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaClient } from '@prisma/client'

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    await this.$connect();
  }
  async testConnection() {
    try {
      await this.$connect();
      console.log('Prisma Client connected successfully');
    } catch (error) {
      console.error('Error connecting Prisma Client:', error);
    }
  }

  async handleCooepeartivesError(e: unknown, name: string) {
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
      // Known error codes: https://www.prisma.io/docs/reference/api-reference/error-reference
      switch (e.code) {
        case 'P2002': // Unique constraint failed
          return ({ message:  'A record with this unique field already exists.' })
        case 'P2025': // Record not found
          return ({ message: `Could not delete the cooperative ${name}` })
        case 'P2003': // Foreign key constraint failed
          return ({ message:  'Foreign key constraint violation.' })  
        default:
          return ({ message:  `Database request error: ${e.message}` })
          
      }
    }
    else if (e instanceof Prisma.PrismaClientUnknownRequestError) {
      return ({message: `Could not the cooperative ${name}`})
    }
    else if (e instanceof Prisma.PrismaClientRustPanicError) {
      return ({
        message:  'The database engine encountered a critical error and crashed. Please try again later.'
      })
    }
    else if (e instanceof Prisma.PrismaClientInitializationError) {
 
      return ({
        message: 'Failed to initialize database connection. Please check your database configuration.'
      })
    }
    else if (e instanceof Prisma.PrismaClientValidationError) {
      return ({
        message: 'Invalid data or query provided to the database client.'
      })
    }
    else {
      // Catch-all fallback
      throw new InternalServerErrorException('An unexpected error occurred.');
    }
  }
}
