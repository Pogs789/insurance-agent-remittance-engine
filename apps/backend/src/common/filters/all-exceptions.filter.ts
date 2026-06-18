import { ArgumentsHost, Catch, ExceptionFilter } from '@nestjs/common';
import type { Response as ExpressResponse } from 'express';
import {
  PrismaClientInitializationError,
  PrismaClientKnownRequestError,
  PrismaClientRustPanicError,
} from '@prisma/client-runtime-utils';

function isConnectionFailure(exception: unknown): boolean {
  if (exception instanceof PrismaClientInitializationError) return true;
  if (exception instanceof PrismaClientRustPanicError) return true;

  if (exception instanceof PrismaClientKnownRequestError) {
    return exception.code === 'ECONNREFUSED';
  }

  return (
    typeof exception === 'object' &&
    exception !== null &&
    'code' in exception &&
    (exception as { code?: string }).code === 'ECONNREFUSED'
  );
}
@Catch(
  PrismaClientKnownRequestError,
  PrismaClientInitializationError,
  PrismaClientRustPanicError,
)
export class PrismaClientExeptionFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<ExpressResponse>();

    if (isConnectionFailure(exception)) {
      response.status(503).json({
        statusCode: 503,
        message:
          'The database is temporarily unavailable. Please try again later.',
      });
      return;
    }

    response.status(500).json({
      statusCode: 500,
      message: 'An unexpected database error occurred.',
    });
  }
}
