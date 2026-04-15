import { MailerService } from '@nestjs-modules/mailer';
import { Injectable } from '@nestjs/common';

@Injectable()
export class MailService {
  constructor(private readonly mailerService: MailerService) {}

  async sendMail(
    to: string,
    subject: string,
    template: string,
    context: {
      firstName: string;
      lastName: string;
      confirmationLink: string;
    },
  ): Promise<void> {
    // Implement mail sending logic using the configured mailer
    await this.mailerService.sendMail({
      to,
      subject,
      template,
      context,
    });
  }
}
