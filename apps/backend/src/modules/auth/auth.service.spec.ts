import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from './auth.service';
import { PrismaService } from '../../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { MailService } from '../mail/mail.service';
import * as fs from 'fs';
import { AppConstants } from '../../common/constants/app.constants';

jest.mock('fs', () => {
  const actualFs: typeof import('fs') = jest.requireActual('fs');

  return {
    ...actualFs,
    existsSync: jest.fn(),
  };
});

describe('AuthService', () => {
  let service: AuthService;
  const sendEmailMock = jest.fn();

  beforeEach(async () => {
    sendEmailMock.mockClear();

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        {
          provide: PrismaService,
          useValue: {
            user: {
              create: jest.fn().mockResolvedValue({ id: 'mock-user-id' }),
              findUnique: jest.fn(),
            },
            insuranceAgent: {
              create: jest.fn().mockResolvedValue({}),
            },
            refreshToken: {
              create: jest.fn(),
              findMany: jest.fn(),
              update: jest.fn(),
            },
            $transaction: jest.fn(),
          },
        },
        {
          provide: AppConstants,
          useValue: {
            saltRounds: 12,
            backeendLink: "http://localhost:3000/api"
          },
        },
        {
          provide: JwtService,
          useValue: {
            signAsync: jest.fn(),
            verifyAsync: jest.fn(),
          },
        },
        {
          provide: MailService,
          useValue: {
            sendMail: sendEmailMock,
          },
        },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create a new agent and sent a successful email', async () => {
    (fs.existsSync as jest.Mock).mockReturnValue(true);

    const result = await service.agentRegister(
      'Juan',
      'Dela',
      'Cruz',
      'San Pedro Insurance Inc.',
      new Date('1990-01-01'),
      'Tahao Rd., Brgy. 69, Legazpi City',
      40,
      'juandelacruz@email.com',
      'Password@123',
    );

    expect(result).toStrictEqual({ success: true });
    expect(sendEmailMock).toHaveBeenCalled();
  });
});
