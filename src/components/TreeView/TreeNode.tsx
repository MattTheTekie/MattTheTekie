import type { ReactNode } from 'react'
import { tv, type VariantProps } from 'tailwind-variants'

const node = tv({
  base: 'flex flex-col',
  variants: {
    type: {
      folder: 'pl-4 py-1',
      file: 'pl-[1.5rem] ml-[0.45rem] py-1 border-l'
    },
    active: {
      never: '',
      false: 'sm:border-stone-800 hover:border-blue-600 hover:text-blue-600 border-stone-700',
      true: 'border-blue-600 text-blue-600'
    }
  }
})

type TreeNodeProps = {
  children?: ReactNode
  pathname?: string | undefined
  slug?: string | undefined
} & VariantProps<typeof node>

export default function Node ({
  children,
  pathname,
  slug,
  type
}: TreeNodeProps): ReactNode {
  if (type === undefined) return null

  if (type !== 'folder') {
    const href = '/brain/' + (slug ?? '')

    return (
      <a
        className={node({
          type,
          active: (pathname ?? '')
            .replace(/\/$/, '') === href
        })}
        href={href}
        aria-label={slug}
        title={slug}
      >
        {children}
      </a>
    )
  }

  return (
    <div className={node({
      type,
      active: 'never'
    })}>
      {children}
    </div>
  )
}