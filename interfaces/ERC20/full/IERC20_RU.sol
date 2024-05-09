// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (последнее обновление v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Интерфейс стандарта ERC-20, как определено в ERC.
 */
interface IERC20 {
    /**
     * @dev Генерируется, когда `value` токенов перемещаются с одного счета (`from`)
     * на другой (`to`).
     *
     * Обратите внимание, что `value` может быть нулем.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Генерируется, когда разрешение `spender` на расходование токенов `owner`
     * устанавливается вызовом {approve}. `value` - это новое разрешение.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Возвращает количество существующих токенов.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Возвращает количество токенов, принадлежащих `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Перемещает `value` количество токенов с счета вызывающего на счет `to`.
     *
     * Возвращает булево значение, указывающее, была ли операция успешной.
     *
     * Генерирует событие {Transfer}.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Возвращает остаточное количество токенов, которое `spender` будет
     * иметь право потратить от имени `owner` через {transferFrom}. По умолчанию это
     * значение равно нулю.
     *
     * Это значение изменяется, когда вызываются {approve} или {transferFrom}.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Устанавливает `value` количество токенов в качестве разрешения `spender`
     * на использование токенов вызывающего.
     *
     * Возвращает булево значение, указывающее, была ли операция успешной.
     *
     * ВАЖНО: Имейте в виду, что изменение разрешения этим методом несет риск
     * использования как старого, так и нового разрешения из-за неудачного
     * порядка транзакций. Одно из возможных решений для уменьшения этой
     * проблемы состязательности - сначала снизить разрешение `spender` до 0 и
     * затем установить желаемое значение:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Генерирует событие {Approval}.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Перемещает `value` количество токенов с `from` на `to`, используя
     * механизм разрешения. Затем `value` вычитается из разрешения вызывающего.
     *
     * Возвращает булево значение, указывающее, была ли операция успешной.
     *
     * Генерирует событие {Transfer}.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}
