import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Global prefix — keeps routes clean and consistent
  app.setGlobalPrefix('api/v1');

  // Enable CORS for web frontends
  app.enableCors();

  const port = process.env.PORT ?? 3000;
  await app.listen(port);
  console.log(`Service running on port ${port}`);
}
bootstrap();
