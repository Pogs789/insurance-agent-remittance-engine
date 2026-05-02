import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module';
import { join } from 'path';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.enableCors();
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      forbidUnknownValues: true,
      transform: true,
    }),
  );
  app.setGlobalPrefix('api');
  app.setBaseViewsDir(join(__dirname, '..', '..', 'views'));
  app.setViewEngine('ejs');
  await app.listen(process.env.PORT ?? 3000);
}

bootstrap().catch((error) => {
  console.error(error);
  process.exit(1);
});
