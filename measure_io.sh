TEST_CMD="dd if=/dev/zero of=/dev/null"
BASE=$(getconf PAGESIZE)
OUT_CSV="results.csv"

echo "scale_factor,buf_bytes,throughput_MBps" > "$OUT_CSV"

for sf in 1 2 4 8 16 32 64 128 256 512; do
  bs=$(( BASE * sf ))
  out=$( $TEST_CMD bs=$bs count=65536 2>&1 )
  thr=$( echo "$out" | grep copied | awk '{print $(NF-1)}' )
  echo "${sf},${bs},${thr}" >> "$OUT_CSV"
done

echo "测试完成，结果保存在 $OUT_CSV"
