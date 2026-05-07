# Report 1 page - Lab 4 DES / TripleDES

## Muc tieu / Objective

- Cai dat DES va TripleDES theo contract stdin.
- Ho tro ma hoa/giai ma, multi-block va zero padding.
- Tao test bat buoc va minh chung qua logs.

## Cach lam / Method

- Giu lai cac bang IP, IP^-1, S-box, permutation va KeyGenerator.
- Them giai ma DES bang viec dung round keys theo thu tu nguoc.
- Tinh nang multi-block: chia 64-bit, pad zero cho block cuoi, ghep ket qua.
- TripleDES theo chuoi E(K3, D(K2, E(K1, P))) va giai ma nguoc.
- Main doc mode va du lieu tu stdin dung thu tu contract.

## Ket qua / Result

- Mode 1/2 chay duoc DES multi-block va pad zero.
- Mode 3/4 chay duoc TripleDES cho 1 block 64-bit.
- Test round-trip va negative tests (tamper, wrong key) khong khoi phuc plaintext.

## Ket luan / Conclusion

- Hoan thanh DES/TripleDES theo contract va input tu ban phim.
- Han che: zero padding khong an toan va khong tu dong bo padding khi giai ma.
- Huong mo rong: dung padding chuan (vi du PKCS#7) va che do khoi manh hon.
