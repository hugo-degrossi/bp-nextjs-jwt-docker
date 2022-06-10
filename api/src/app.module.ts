import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { LocalAuthGuard } from './auth/local-auth.guard';
import { UsersModule } from './users/users.module';

@Module({
  imports: [AuthModule, UsersModule, LocalAuthGuard],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
