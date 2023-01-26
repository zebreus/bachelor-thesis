mod min_max_rust;
mod min_max_rust_idiomatic;

#[no_mangle]
pub extern "C" fn addition(left: usize, right: usize) -> usize {
    left + right
}

#[no_mangle]
pub extern "C" fn recursive_addition(left: usize, right: usize) -> usize {
    if right == 0 {
        return left;
    }
    return 1 + addition(left, right - 1);
}

const BUBBLESORT_SIZE: usize = 10;

#[no_mangle]
pub extern "C" fn bubble_sort(arr: &mut [u32; 10]) {
    for i in 0..BUBBLESORT_SIZE {
        for j in 0..BUBBLESORT_SIZE - 1 - i {
            if arr[j] > arr[j + 1] {
                arr.swap(j, j + 1);
            }
        }
    }
}
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = addition(2, 2);
        assert_eq!(result, 4);
    }

    #[test]
    fn sorting_ordered_works() {
        let mut input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        bubble_sort(&mut input);
        assert_eq!(input, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    }

    #[test]
    fn sorting_unordered_works() {
        let mut input = [8, 1, 6, 2, 10, 3, 5, 9, 4, 7];
        bubble_sort(&mut input);
        assert_eq!(input, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    }
}
