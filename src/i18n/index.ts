import { de } from "./de";
import { en } from "./en";

export const translations = { de, en } as const;

export type Locale = keyof typeof translations;

export function getTranslations(locale: Locale) {
  return translations[locale];
}

export const locales = ["de", "en"] as const;
export const defaultLocale = "de";
