import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import helmet from 'helmet';
import { ValidationPipe } from '@nestjs/common';
// import { doubleCsrf } from 'csrf-csrf';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    // origin: ['http://localhost:3200', 'http://10.30.251.178:3200'],
    origin: '*',
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
    // credentials: 'false',
  })
   app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,       // remove unknown properties from body
      forbidNonWhitelisted: true, // throw error if unknown props found
      transform: true,       // auto-transform payloads to DTO instances
    }),
  );

  app.use(helmet())
  await app.listen(process.env.PORT ?? 3200);
}
bootstrap();
