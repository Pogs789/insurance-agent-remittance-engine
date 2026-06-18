import { SetMetadata } from '@nestjs/common';

export const IS_PUBLIC_KEY = 'isPublic';

//This is a decorator in which it identifies that this API is accessible to everyone regardless if it is inside or outside my mobile app.
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);
