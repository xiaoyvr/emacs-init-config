import iconv from 'https://dev.jspm.io/iconv-lite'

async function fixFile(name: string, encoding: string) {
    const file = await Deno.readFile(name)
    const text = iconv.decode(new Deno.Buffer(file.buffer).bytes(), encoding)
    await Deno.rename(name, name + '.bk')
    await Deno.writeTextFile(name, text)
}

const promises: Promise<void>[] = []
for (const d of Deno.readDirSync('.')) {
    if(d.name.endsWith('.cue')) {
        promises.push(fixFile(d.name, 'gbk'))
    }
}
await Promise.all(promises)